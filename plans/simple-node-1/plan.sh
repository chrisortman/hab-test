pkg_name=simple-node-1
pkg_origin=chrisortman
pkg_description="This version uses a magic secret value to affect its output and adds all hooks"
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(core/node)
pkg_license=('Apache-2.0')
pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"

pkg_exports=(
  [magic]=awesome.magic_secret
  [dport]=other.port
)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir -p $CACHE_PATH
  cp -a $PLAN_CONTEXT/source $CACHE_PATH/source
}

do_build() {
  cd $CACHE_PATH/source
  npm install
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}"
  cp -a . "${pkg_prefix}"
  return 0
}

do_strip() {
  return 0
}
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
# pkg_shasum="TODO"
# pkg_deps=(core/glibc)
# pkg_build_deps=(core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="bin/haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"
