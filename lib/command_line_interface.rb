require_relative '../config/environment.rb'

def welcome
    puts "Welcome to the world of Studio Ghibli!"
    puts "　　　　　　　　　　　　　　　　 ﾍ"
    puts "　　　　　　　　　　　　　　ﾍ　/ |"
    puts "　　　　　　　　　　　　　/ ｜/　|"
    puts "　　　　　　　　　    　 ﾉ　|ﾉ 　|"
    puts "　　　　　　　　　 　　 ﾐ} F′〉 ｯ┘"
    puts "　 　 　　　　　　    . -┴┴‐ミ  ﾐ._"
    puts "　 　 　　　　　　> ´　　　　　　　ミ､"
    puts "　　　　　　　　/　　　　　　　　 　 ﾐ､"
    puts "　　　　　　　 ﾉ　　p￣ヽ_　　　　 　 ﾐ､"
    puts "　　　　　 rﾍ⌒　　 `ー ′　　　　　　   ﾐ､"
    puts "　　　  ﾆ{^　　　　　　　　　　　　　   ﾐ､"
    puts "　　　　 〈､_　　　＝三二_ー--　　　　   ﾐ､"
    puts "　　　　 ∠_ 　　　　ｰ＝= 二_ｰ             ﾐ､"
    puts "　 　  ／　¨ヾ､                           ﾐ､"
    puts "　    ﾉﾍ　　　ヽ                           l"
end

def choices
    puts "Please input a number for the option you would like to choose:"
    puts "1. List all Ghibli film titles"
    puts "2. List my favorites"
    puts "3. Add a film to my favorites by name"
    puts "0. Exit the CLI"
    gets.strip
end

def film_list
    Film.all.each { |film| puts film.title }
end

def run
    welcome
    choice = choices
    film_list
end

run