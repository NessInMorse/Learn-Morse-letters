#gem install win32-sound
require 'win32/sound'
include Win32

module Morse
        def Dot 
                Sound.beep(500, 100)
        end

        def Dash
                Sound.beep(500,500)
        end
end


include Morse
module Pauzes
        def Inter_letter
                @@inter_letter=sleep(100/1000)
        end

        def Intra_letter
                @@intra_letter=sleep(1000/1000)
        end

        def Spatie
                @@space=sleep(1500/1000)
        end

        def Regel
                @@rule=sleep(2500/1000)
        end
end
include Pauzes


module Morsify
        @@morse=[".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        def MakeMorse(text)
                @@morse[(text.downcase.ord-97)]
        end

        @@c=0
        @@round=0
        @@win=0
        def Sound(morse,text)
                while @@c<morse.length
                        case morse[@@c]
                                when "."
                                        Morse.Dot
                                when "-"
                                        Morse.Dash
                                when " "
                                        Pauzes.Intra_letter
                        end
                        Pauzes.Inter_letter
                @@c+=1

                        if @@c==morse.length
                                puts "What was the letter"
                                ask=gets.chomp()
                                case ask
                                        when text
                                                @@win+=1
                                                @@round+=1
                                        puts "it was indeed: #{text} #{@@win}/#{@@round}"
                                        when "retry"
                                                @@c=0
                                        else @@round+=1
                                                puts "The word was: #{text} #{@@win}/#{@@round}"
                                        
                                end
                        end
                end
                @@c=0
        end

end
include Morsify



ask=""
win=0
round=0
while ask!="no"
        text=(97+rand(26)).chr
        Morsify.MakeMorse(text)
        Morsify.Sound(Morsify.MakeMorse(text),text)
end