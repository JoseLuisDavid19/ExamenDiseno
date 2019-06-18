#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include <iostream>
#include <chrono>
#include <random>
#include "doctest.h"
#include "VLCMMain.h"
#include "VLCMMain_LCMMain.h"
#include "VLCMMain_LCMFSM.h"

void reset(VLCMMain& m) {
    m.rst = 1;
    m.clk = 0;
    m.eval();
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.rst = 0;
    m.eval();
}

void clockPulse(VLCMMain& m) {
    m.clk = 1;
    m.eval();
    m.clk = 0;
    m.eval();
}

static const unsigned finalState = 5;

std::vector<std::tuple<unsigned, unsigned, unsigned>> test_lcd = {
    {930, 1302, 6510},
    {2852, 18538, 37076},
    {1442, 3591, 739746},
    {1920, 3368, 808320},
    {1279, 29417, 29417},
    {1693, 45711, 45711},
    {48, 3568, 10704},
    {1048, 418, 219032},
    {2890, 3170, 916130},
    {3665, 145, 106285},
};

TEST_CASE("LCM test") {
    VLCMMain m;

    for (auto& tt : test_lcd) {
        unsigned n1 = std::get<0>(tt);
        unsigned n2 = std::get<1>(tt);
        unsigned result = std::get<2>(tt);

        reset(m);
        m.n1 = n1;
        m.n2 = n2;
        m.eval();
        while (m.LCMMain->fsm->cs != finalState) {
            clockPulse(m);
            std::cout<<'CS '<<m.LCMMain->fsm->cs<<' ';
        }

        CHECK(m.result == result);
    }
}
