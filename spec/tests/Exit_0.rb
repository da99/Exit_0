
describe "Exit_0 *cmd" do

  it "accepts the same arguments as POSIX::Spawn::Child" do
    Exit_0("dc", :input=>'4 4 + p').out
    .should == "8"
  end

  it "raises Exit_0::Non_0 if command exits with non-0" do
    lambda {
      Exit_0 'uptimes'
    }.should.raise(Exit_0::Non_0)
    .message.should.match %r!127 => bash: uptimes: command not found!
  end

  it "returns a Exit_0::Child" do
    Exit_0('whoami').class.should.be == Exit_0::Child
  end

  it "executes valid command" do
    Exit_0('pwd').out.should == `pwd`.strip
  end

  it "raises ArgumentError if both a cmd and block are given" do
    lambda { Exit_0('uptime') {} }
    .should.raise(ArgumentError)
    .message.should.match %r!are not allowed!i
  end

  it "combines a multi-line string into one string, joined by \"&&\"" do
    Exit_0(%!
      cd ~/
      pwd
    !)
    .out.should == `cd ~/ && pwd`.strip
  end

  it "ignores empty lines in a multi-line string" do
    Exit_0(%!
      cd ~/

      pwd
    !).out.should == `cd ~/ && pwd`.strip
  end

end # === Exit_0 'cmd'

describe "Exit_0 { }" do
  
  it "returns last value of the block" do
    Exit_0{ POSIX::Spawn::Child.new("ls ~") }
    .out.should. == `ls ~`
  end

  it "raises Exit_0::Non_0 if return value has exitstatus != 0" do
    b = lambda { POSIX::Spawn::Child.new("something_not_found") }
    lambda {
      Exit_0(&b)
    }.should.raise(Exit_0::Non_0)
    .message.should == "127 => #{b.inspect}"
  end
  
  it "raise Unknown_Exit if block return value does not respond to :status and :exitstatus" do
    target = lambda { :a }
    lambda {
      Exit_0(&target)
    }.should.raise(Exit_0::Unknown_Exit)
    .message.should.match %r!#{Regexp.escape target.inspect}!
  end
  
end # === Exit_0 { }

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

