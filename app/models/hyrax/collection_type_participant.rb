module Hyrax
  class CollectionTypeParticipant < ActiveRecord::Base
    self.table_name = 'collection_type_participants'
    belongs_to :hyrax_collection_type, class_name: 'CollectionType', foreign_key: 'hyrax_collection_type_id'
    validates :agent_id, presence: true
    validates :agent_type, presence: true
    validates :access, presence: true
    validates :hyrax_collection_type_id, presence: true

    MANAGE_ACCESS = 'manage'.freeze
    CREATE_ACCESS = 'create'.freeze

    GROUP_TYPE = 'group'.freeze
    USER_TYPE = 'user'.freeze

    def manager?
      access == MANAGE_ACCESS
    end

    def creator?
      access == CREATE_ACCESS
    end

    def label
      return agent_id unless agent_type == GROUP_TYPE
      case agent_id
      when 'registered'
        I18n.t('hyrax.admin.admin_sets.form_participant_table.registered_users')
      when ::Ability.admin_group_name
        I18n.t('hyrax.admin.admin_sets.form_participant_table.admin_users')
      else
        agent_id
      end
    end
  end
end
