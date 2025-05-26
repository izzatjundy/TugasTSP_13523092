# Nama: Muhammad Izzat Jundy
# NIM: 13523092

require_relative 'module/tsp'

puts "Selamat datang di TSP Solver!"
puts "Program ini akan membantu Anda menyelesaikan masalah Traveling Salesman Problem (TSP)."
puts "Silakan masukkan nama Anda:"
name = gets.chomp

while true

    puts
    puts "Selamat datang, #{name}!"
    puts
    puts "Silakan pilih metode input yang Anda inginkan:"
    puts "1. Input manual"
    puts "2. Input dari file"
    puts "0. Keluar"
    print "> "
    cmd = gets.chomp

    puts
    if(cmd == "0")
        puts "Terima kasih telah menggunakan TSP Solver. Sampai jumpa!"
        exit
    elsif(cmd == "1")
        puts "Masukkan jumlah kota:"
        print "> "
        n = gets.to_i
        puts "Masukkan jarak antar kota (pisahkan dengan spasi):"
        dist = Array.new(n) { gets.split.map(&:to_i) }
    elsif(cmd == "2")
        puts "Masukkan nama file (misal: test.txt):"
        print "> "
        filename = "test/" + gets.chomp
        begin
            lines = File.readlines(filename, chomp: true)
            n = lines[0].to_i
            dist = lines[1..].map { |line| line.split.map(&:to_i) }
        rescue Errno::ENOENT
            puts "File tidak ditemukan. Silakan coba lagi."
            next
        end
    else
        puts "Pilihan tidak valid. Silakan coba lagi."
        next
        end
    
    
    puts
    puts "Jumlah kota: #{n}"
    puts "Jarak antar kota:"
    dist.each { |row| puts row.join(" ") }

    puts
    puts "Menghitung solusi TSP..."
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    TSP.init(n)
    res = TSP.tsp(0, 1, dist)
    path = TSP.reconstruct_path(0, 1)
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    
    duration = ((end_time - start_time) * 1000).round(3)

    puts
    puts "Solusi TSP ditemukan dengan biaya minimum: #{res} (#{path.join(" -> ")})"
    puts "Waktu eksekusi: #{duration} ms"

    while true
        puts
        puts "Apakah Anda ingin menyimpan hasilnya ke file? (y/n)"
        print "> "
        cmd = gets.chomp.downcase
        if cmd == 'y'
            puts
            puts "Masukkan nama file untuk menyimpan hasil (misal: output-test.txt):"
            print "> "
            filename = "test/" + gets.chomp
            begin
                File.open(filename, 'w') do |file|
                    file.puts "Jumlah kota: #{n}"
                    file.puts "Jarak antar kota:"
                    dist.each { |row| file.puts row.join(" ") }
                    file.puts
                    file.puts "Solusi TSP ditemukan dengan biaya minimum: #{res} (#{path.join(" -> ")})"
                    file.puts "Waktu eksekusi: #{duration} ms"
                end
                puts
                puts "Hasil berhasil disimpan ke #{filename}."
            rescue => e
                puts
                puts "Terjadi kesalahan saat menyimpan file: #{e.message}"
            end
            break
        elsif cmd == 'n'
            puts
            puts "Hasil tidak disimpan."
            break
        else
            puts
            puts "Pilihan tidak valid. Silakan jawab dengan 'y' atau 'n'."
        end
    end

    while true
        puts
        puts "Apakah Anda ingin menguji kasus lain? (y/n)"
        print "> "
        cmd = gets.chomp.downcase
        if cmd == 'y'
            break
        elsif cmd == 'n'
            puts
            puts "Terima kasih telah menggunakan TSP Solver. Sampai jumpa, #{name}!"
            exit
        else
            puts
            puts "Pilihan tidak valid. Silakan jawab dengan 'y' atau 'n'."
        end
    end
end