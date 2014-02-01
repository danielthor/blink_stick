require_relative '../../test_helper'
 
describe Color do

  it "must define Color::NAMES hash" do
    Color::NAMES.must_be_kind_of Hash
  end

  it "must parse all named colors" do
    Color::NAMES.each do |name, rgb|
      Color.parse(name.to_s).must_equal rgb
    end
  end

end
