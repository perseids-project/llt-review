require 'sinatra/base'
require 'sinatra/respond_with'
require 'llt/review'
require 'llt/review/api/helpers'

class Api < Sinatra::Base
  register Sinatra::RespondWith

  set :root, File.expand_path('../../../..', __FILE__)


  helpers LLT::Review::Api::Helpers

  get '/:type/diff' do
    diff = process_diff(params)

    respond_to do |f|
      f.xml { diff.to_xml }
    end
  end

  get '/:type/diff/:view' do
    diff = process_diff(params)

    if params[:view] == 'html'
      haml :index, locals: { diff: diff }
    end
  end

  get '/:type/report' do
    uris = Array(params[:uri])
    klass = params[:type]
    reporter = LLT::Review.const_get(klass.capitalize).new
    reporter.report(*uris)

    respond_to do |f|
      f.xml { reporter.to_xml(:report)}
    end
  end

  def process_diff(params)
    gold = Array(params[:gold])
    rev  = Array(params[:reviewable])

    comp_param = params[:compare]
    comparables = comp_param ? Array(comp_param).map(&:to_sym) : nil

    klass = params[:type]
    # return an error if klass is neither treebank nor Alignment

    diff = LLT::Review.const_get(klass.capitalize).new
    diff.diff(gold, rev, comparables)
    diff
  end
end
