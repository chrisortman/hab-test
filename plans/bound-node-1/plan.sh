pkg_name=bound-node-1
pkg_origin=chrisortman
pkg_description="This version needs to be bound to something that will tell it which port to run on. It assumes simple-node-1 is running because it starts a node server serving the simple-node-1 files"
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(core/node)
pkg_license=('Apache-2.0')
pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"

pkg_binds=(
  [base]="dport"
)

do_begin() {
  return 0
}

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
