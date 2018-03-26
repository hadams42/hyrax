module Hyrax
  module ManagesEmbargoes
    extend ActiveSupport::Concern

    included do
      attr_accessor :curation_concern
      helper_method :curation_concern
      load_and_authorize_resource class: ActiveFedora::Base, instance_name: :curation_concern
    end

    # This is an override of Hyrax::ApplicationController
    def deny_access(exception)
      redirect_to root_path, alert: exception.message
    end

    def edit
      add_breadcrumb t(:'hyrax.controls.home'), root_path
      add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    end
  end
end
