require 'spec_helper'

describe EventTemplate do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: event_templates
#
#  id                  :integer         not null, primary key
#  mission_template_id :integer
#  title               :string(255)
#  description         :text
#  parent_event_id     :integer
#  latitude            :float
#  longitude           :float
#  radius              :float
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

