create_clock -name CLOCK_50 -period 50MHz [get_ports CLOCK_50]
derive_clock_uncertainty
derive_pll_clocks
