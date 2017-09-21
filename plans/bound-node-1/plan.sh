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
  for f in file_updated health_check reconfigure reload suitability
  do
    cp $PLAN_CONTEXT/../simple-node-1/hooks/$f hooks/$f
  done
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  return 0
}

do_strip() {
  return 0
}
