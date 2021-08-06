local jdtls = require("jdtls")
local setup = require("jdtls.setup")

jdtls.start_or_attach({
  cmd = { "jdtls" },
  root_dir = { setup.find_root({
    ".git", "mvnw", "gradlew", "gradle.build", "pom.xml",
  }) },
})
