/*******************************************************************************
** Copyright (c) 2017 Ring.com.
** All Rights Reserved.
**
** This software is a proprietary document of Ring company, and shall not be
** reproduced, distributed or copied for purposes other than the intended use
** without written permission of Ring company.
********************************************************************************
**   Project     :   RING
**   Authors     :   Taras Zaporozhets (taras.zaporozhets@ring.com)
**   Date Created:   2017-03-21
*******************************************************************************/
import qbs
Project {
    CppApplication {
        property string targetDevice: "unicorn"

        name: "QbsProjectExample-" + targetDevice

        consoleApplication: true
        cpp.warningLevel: "all"
        cpp.treatWarningsAsErrors: true
        cpp.cxxLanguageVersion: "c++11"

        files: [
            "src/**",
        ]
        cpp.includePaths: [
            "src/include",
        ]

        cpp.libraryPaths: [

        ]

        cpp.dynamicLibraries: [

        ]


        Group {
            fileTagsFilter: product.type
            qbs.install: true
            qbs.installDir: "/tmp/"
        }
    }
}

