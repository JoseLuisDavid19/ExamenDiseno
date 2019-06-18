#include <iostream>
#include <chrono>
#include <random>

unsigned getRandNumber() {
    static unsigned seed = std::chrono::steady_clock::now().time_since_epoch().count();
    static std::default_random_engine re(seed);
    std::uniform_int_distribution<> dist(10, (1 << 12)-1);

    return dist(re);
}

unsigned lcm(unsigned n1, unsigned n2)
{
    unsigned minMultiple = (n1>n2) ? n1 : n2;

    while(true)
    {
        if((minMultiple % n1 == 0) && (minMultiple % n2 == 0)) {
            break;
        }
        ++minMultiple;
    }
    return minMultiple;
}

int main()
{
    std::cout << "std::vector<std::tuple<unsigned, unsigned, unsigned>> test_lcd = {\n";
    
    for (int i = 0; i < 10; i++) {
        unsigned n1 = getRandNumber();
        unsigned n2 = getRandNumber();
    
        std::cout << "    " << n1 << ", " << n2 << ", " << lcm(n1, n2) << ",\n";
    }
    std::cout << "}\n";
}
