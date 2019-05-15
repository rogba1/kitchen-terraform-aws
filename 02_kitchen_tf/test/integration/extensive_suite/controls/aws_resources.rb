vpc_id_kt = attribute('vpc_id', description: 'VPC ID')
s3_bucket_kt = attribute('s3_bucket_address', description: 'S3 Bucket address')


control 'aws_resources' do
  describe aws_vpc(vpc_id_kt) do
    it { should exist }
    its('cidr_block') { should eq '10.0.0.0/16' }
  end


  describe aws_s3_bucket(bucket_name: 'clusters.k8uxscope.com') do
  it { should exist }
  it { should have_access_logging_enabled }
  end

end
