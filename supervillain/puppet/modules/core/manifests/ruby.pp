class core::ruby{
    $packageList = [
        'gcc',
        'gcc-c++',
        'ruby',
        'rubygems',
        'ruby-devel'
    ]

    package{ $packageList: }
}
