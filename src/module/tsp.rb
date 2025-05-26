module TSP
    def self.init(n)
        @visited_all = 2**n - 1
        @dp = Array.new(n) { Array.new(1 << n, -1) }
        @path = Array.new(n) { Array.new(1 << n, nil) }
    end

    def self.tsp(pos, visited, dist)
        return dist[pos][0] if visited == @visited_all
        return @dp[pos][visited] if @dp[pos][visited] != -1

        min_cost = Float::INFINITY
        (0...dist.size).each do |city|
            next if visited & (1 << city) != 0
            cost = dist[pos][city] + tsp(city, visited | (1 << city), dist)
            if cost < min_cost
                min_cost = cost
                @path[pos][visited] = city
            end
        end

        @dp[pos][visited] = min_cost
    end

    def self.reconstruct_path(start, visited)
        path = [start]
        while next_city = @path[start][visited]
            path << next_city
            visited |= (1 << next_city)
            start = next_city
        end
        path << 0
        path
    end
end