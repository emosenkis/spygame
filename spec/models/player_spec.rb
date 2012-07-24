# == Schema Information
#
# Table name: players
#
#  id            :integer         not null, primary key
#  game_state_id :integer
#  user_id       :integer
#  role          :string(255)
#  state         :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Player do
  pending "add some examples to (or delete) #{__FILE__}"
end
