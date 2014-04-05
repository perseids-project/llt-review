require 'sinatra/base'
require 'sinatra/respond_with'
require 'llt/review'

class Api < Sinatra::Base
  register Sinatra::RespondWith

  get '/:type/diff' do
    gold = Array(params[:gold])
    rev  = Array(params[:reviewable])

    klass = params[:type]
    # return an error if klass is neither treebank nor Alignment

    diff = LLT::Review.const_get(klass.capitalize).new
    diff.diff(gold, rev)

    respond_to do |f|
      f.xml { diff.to_xml }
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
end
