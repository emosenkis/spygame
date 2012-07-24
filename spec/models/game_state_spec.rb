# == Schema Information
#
# Table name: game_states
#
#  id                 :integer         not null, primary key
#  date_time_of_start :datetime
#  game_template_id   :integer
#  state              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  data               :text
#

require 'spec_helper'

describe GameState do
  pending "add some examples to (or delete) #{__FILE__}"
end
