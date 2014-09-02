


describe "exit_0 String" do


  it "raises Exit_0::Non_0 if command exits with non-0" do
    lambda {
      exit_0 '
        uptimes
      '
    }.should.raise(Exit_0::Non_0)
    .message.should.match %r!127 => sh: 1: uptimes: not found!
  end

  it "executes valid command" do
    exit_0('pwd').should == `pwd`.strip
  end

  it "combines a multi-line string into one string, joined by \"&&\"" do
    exit_0(%!
      cd ~/
      pwd
    !)
    .should == `cd ~/ && pwd`.strip
  end

  it "ignores empty lines in a multi-line string" do
    exit_0(%!
      cd ~/

      pwd
    !).should == `cd ~/ && pwd`.strip
  end

end # === Exit_0 'cmd'



