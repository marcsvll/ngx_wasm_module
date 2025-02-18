# vim:set ft= ts=4 sts=4 sw=4 et fdm=marker:

use strict;
use lib '.';
use t::TestWasm;

add_block_preprocessor(sub {
    my $block = shift;
    my $main_config = <<_EOC_;
        wasm {
            module ngx_rust_tests $t::TestWasm::crates/ngx_rust_tests.wasm;
        }
_EOC_

    if (!defined $block->main_config) {
        $block->set_value("main_config", $main_config);
    }
});

plan_tests(3);
run_tests();

__DATA__

=== TEST 1: resp_set_status: sets status code in 'rewrite' phase
--- SKIP
--- config
    location /t {
        wasm_call rewrite ngx_rust_tests set_resp_status;
    }
--- response_body
--- no_error_log
[error]



=== TEST 2: resp_set_status: sets status code in 'content' phase
--- config
    location /t {
        wasm_call content ngx_rust_tests set_resp_status;
        wasm_call content ngx_rust_tests say_hello;
    }
--- error_code: 201
--- response_body
hello say
--- no_error_log
[error]



=== TEST 3: resp_set_status: bad usage in 'log' phase
--- config
    location /t {
        return 200;
        wasm_call log ngx_rust_tests set_resp_status;
    }
--- ignore_response_body
--- grep_error_log eval: qr/(\[error\] .*?|.*?host trap).*/
--- grep_error_log_out eval
qr/.*?(\[error\]|Uncaught RuntimeError: |\s+)host trap \(bad usage\): headers already sent.*/
--- no_error_log
[alert]
