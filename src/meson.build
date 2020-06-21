rokuremote_sources = [
  'main.vala',
  'window.vala',
  'roku_manager.vala',
  'roku_device.vala'
]

rokuremote_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('libsoup-2.4', version: '>= 2.70'),
  dependency('gssdp-1.2', version: '>= 1.0.0'),
  dependency('gupnp-1.2', version: '>= 1.0.0'),
  dependency('gxml-0.18', version: '>= 0.18')
]

gnome = import('gnome')

rokuremote_sources += gnome.compile_resources('rokuremote-resources',
  'rokuremote.gresource.xml',
  c_name: 'rokuremote'
)

executable('rokuremote', rokuremote_sources,
  vala_args: '--target-glib=2.50',  dependencies: rokuremote_deps,
  install: true,
)
