function is_devisible(n,i)
return n%i==0
end

function is_prime(n::Int64)
if n<=3
        return true
end
if n%2==0
        return false
end

#here we initialize an iterator
i=3
while i<=sqrt(n)
        if is_devisible(n,i)
                return false
        end
        i=i+2
end

return true
end

println (is_prime(101))
