return {
    filetypes = { "java" },
    cmd = {
        "jdtls", "-Xmx1G", "--add-modules=ALL-SYSTEM", "-data",
        os.getenv("HOME") .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    },
    root_markers = {
        '.git',
        'mvnw',
        'gradlew',
        'build.gradle',
        'build.gradle.kts',
        'pom.xml',
        'build.xml',
        'settings.gradle',
        'settings.gradle.kts',
        '.classpath'
    },
}
