# require 'spec_helper'
# require 'sidekiq/testing'

# describe PDFWorker do
#   Sidekiq::Testing.fake!

#   it "should add jobs to the queue" do
#     expect {
#       PDFWorker.perform_async(1, 2)
#     }.to change(PDFWorker.jobs, :size).by(1)
#   end
# end
