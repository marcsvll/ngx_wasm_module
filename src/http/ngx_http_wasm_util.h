#ifndef _NGX_HTTP_WASM_UTIL_H_INCLUDED_
#define _NGX_HTTP_WASM_UTIL_H_INCLUDED_


#include <ngx_http_wasm.h>


ngx_str_t *ngx_http_copy_escaped(ngx_str_t *dst, ngx_pool_t *pool,
    ngx_http_wasm_escape_kind kind);
ngx_int_t ngx_http_wasm_send_chain_link(ngx_http_request_t *r, ngx_chain_t *in);


#endif /* _NGX_HTTP_WASM_UTIL_H_INCLUDED_ */
