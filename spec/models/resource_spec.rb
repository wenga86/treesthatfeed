require 'spec_helper'

describe Resource do
  describe '#fullpath' do
    it 'should be ::Rails.root.to_s + "/public/files/" + resource.filename' do
      res = FactoryGirl.create(:resource, :filename => 'a_new_file')
      res.fullpath.should == ::Rails.root.to_s + "/public/files/a_new_file"
    end
  end

  describe "scopes" do
    describe "#without_images" do
      it "should list resource that are not image (based on mime type)" do
        other_resource = FactoryGirl.create(:resource, :mime => 'text/css')
        image_resource = FactoryGirl.create(:resource, :mime => 'image/jpeg')
        Resource.without_images.should == [other_resource]
      end
    end

    describe "#images" do
      it "should list only images (based on mime type)" do
        other_resource = FactoryGirl.create(:resource, :mime => 'text/css')
        image_resource = FactoryGirl.create(:resource, :mime => 'image/jpeg')
        Resource.images.should == [image_resource]
      end

    end

    describe "#by_filename" do
      it "should sort resource by filename" do
        b_resource = FactoryGirl.create(:resource, :filename => 'b')
        a_resource = FactoryGirl.create(:resource, :filename => 'a')
        Resource.by_filename.should == [a_resource, b_resource]
      end
    end

    describe "#by_created_at" do
      it "should sort resource by created_at DESC" do
        b_resource = FactoryGirl.create(:resource, :created_at => DateTime.new(2011,03,13))
        a_resource = FactoryGirl.create(:resource, :created_at => DateTime.new(2011,02,21))
        Resource.by_created_at.should == [b_resource, a_resource]
      end
    end

     describe "#without_images_by_filename" do
      it "should combine 2 scopes" do
        image_resource = FactoryGirl.create(:resource, :mime => 'image/jpeg')
        b_resource = FactoryGirl.create(:resource, :mime => 'text/html', :filename => 'b')
        a_resource = FactoryGirl.create(:resource, :mime => 'text/html', :filename => 'a')
        Resource.without_images_by_filename.should == [a_resource, b_resource]
      end
    end


  end

  it 'resources created with the same name as an existing resource don\'t overwrite the old resource' do
    File.stub!(:exist?).and_return(true)
    File.should_receive(:exist?).with(%r{public/files/me\.jpg$}).and_return(true)
    File.should_receive(:exist?).with(%r{public/files/me1\.jpg$}).at_least(:once).and_return(false)

    f1 = FactoryGirl.create(:resource, :filename => 'me.jpg')
    f1.should be_valid
    f1.filename.should == 'me1.jpg'
  end

  it 'a resource deletes its associated file on destruction' do
    File.should_receive(:exist?).and_return(false)
    res = FactoryGirl.create(:resource, :filename => 'file_name')

    File.should_receive(:exist?).with(res.fullpath).and_return(true)
    File.should_receive(:unlink).with(res.fullpath).and_return(true)
    res.destroy
  end

  describe "create_and_upload" do
    it "calls create and upload" do
      now = Time.new(2012,1,23,23,45)
      Time.stub(:now).and_return(now)
      file = OpenStruct.new(original_filename: 'orig', content_type: "mime")

      resource = FactoryGirl.build(:resource)
      Resource.should_receive(:create).with(filename: "orig", mime: "mime", created_at: now).and_return(resource)
      resource.should_receive(:upload).with(file).and_return(resource)

      Resource.create_and_upload(file)
    end
  end
end
