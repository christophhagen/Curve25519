Pod::Spec.new do |spec|
    spec.name = 'Curve25519'
    spec.summary = 'Module wrapper for Curve25519 that is importable in Swift.'
    spec.license = 'MIT'

    spec.version = '0.6'
    spec.source = {
        :git => 'https://github.com/christophhagen/Curve25519.git',
        :tag => spec.version
    }

    spec.authors = { 'Christoph Hagen' => 'christoph@spacemasters.eu' } 
    spec.homepage = 'https://github.com/christophhagen/Curve25519'

    spec.ios.deployment_target = '9.0'
    spec.osx.deployment_target = '10.9'
    spec.tvos.deployment_target = '9.0'
    spec.watchos.deployment_target = '4.0'

    spec.source_files = 'Curve25519/**/*.{swift,h,c}'
    spec.public_header_files = 'Curve25519/pub/*.h'
end