require 'spec_helper'

log_in_admin

visit file_upload_path
page.should have_content 'Select file to upload to X table'

file_path =  '../fixtures/X_input.csv'

fill_in 'file_upload_box', with: file_path
# or
page.attach_file 'file_upload_box', file_path

click 'Upload'

page.should have_content '2 records successfully uploaded'
