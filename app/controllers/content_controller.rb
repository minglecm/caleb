class ContentController < ApplicationController
  def index
    fonts = ["Times New Roman", "Comic Sans MS", "Courier New", "Courier", "Tahoma", "Impact"]
    colors = %w{yellow orange grey green blue peru pink magenta white}
    backgrounds = [
        "http://www.cse.iitb.ac.in/~anush/Matrix.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/lego2.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/rcarsping.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/tiger.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/skater.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/bowlingboom.gif",
        "http://www.mikesfreegifs.com/main4/coolsick/f18roll.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/Camaro-02.gif",
        "http://www.mikesfreegifs.com/main4/miscellanious/Fountain-01.gif"
    ]

    @font       = fonts.sample
    @color      = colors.sample
    @background = backgrounds.sample
  end
end
