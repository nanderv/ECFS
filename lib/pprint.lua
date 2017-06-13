return function(a)
    print("-------------------")
    print(a)
    print(require 'lib.inspect'(a))
    print("-------------------")
end