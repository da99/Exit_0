describe "Child.new" do
  
  it 'executes given string' do
    Exit_0::Child.new("pwd").raw_out.should == `pwd`
  end
  
end # === Exit_0::Child

describe "Child#split_lines" do
  
  it "returns split lines of output through :split_lines" do
    r = Exit_0::Child.new('ls -Al')
    r.split_lines.should == `ls -Al`.strip.split("\n")
  end
  
end # === Child#split_lines

describe "Child delegate methods" do
  
  %w{ raw_out raw_err status }.each { |m|
    o_m = m.sub("raw_", '')
    it "sets :#{m} equal to Child :#{o_m}" do
      cmd = %q! ruby -e "puts 'a'; warn 'b'; exit(127);"!
      target = POSIX::Spawn::Child.new(cmd)
      Exit_0::Child.new(cmd)
      .send(m).should == target.send(o_m)
    end
  }
  
end # === Child delegate methods

describe "Exit_0::Child" do

    # ---- :out
  
    it "returns stripped :out" do
      Exit_0::Child.new("pwd").out
      .should == `pwd`.strip
    end

    it "returns raw output for :raw_out" do
      Exit_0::Child.new("pwd").raw_out
      .should == `pwd`
    end
    
    # ---- :err 
    
    it "returns stripped :err" do
      Exit_0::Child.new("pwdssssss").err
      .should == `bash -lc "pwdssssss" 2>&1`.strip
    end

    it "returns raw output for :raw_out" do
      Exit_0::Child.new("no_exist").err
      .should.match %r!no_exist: command not found!
    end
  
end # === Exit_0::Child




