pkg_name=eight
pkg_origin=chrisortman
pkg_description="This version uses a magic secret value to affect its output and adds all hooks"
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(core/node8 core/busybox-static)
pkg_license=('Apache-2.0')
pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_bin_dirs=(bin)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir -p $CACHE_PATH
  cp -a $PLAN_CONTEXT/source $CACHE_PATH/source
  return 0
}

do_clean() {
  do_default_clean
}

do_build() {
  cd $CACHE_PATH/source
  npm install
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp -a . "${pkg_prefix}"
  local bin="${pkg_prefix}/bin/${pkg_name}"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e

exec $(pkg_path_for node8)/bin/node $pkg_prefix/source/server.js \$@
EOF
  chmod -v 755 "$bin"
  return 0
}

do_strip() {
  return 0
}
