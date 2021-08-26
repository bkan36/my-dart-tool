String jestUnitfile() => '''
{
    "moduleNameMapper": {
        "src/(.*)": "<rootDir>/src/\$1",
        "test/(.*)": "<rootDir>/__test__/\$1"
    },
    "moduleFileExtensions": [
        "js",
        "json",
        "ts"
    ],
    "rootDir": "../../../",
    "testEnvironment": "node",
    "testRegex": ".spec.ts\$",
    "transform": {
        "^.+\\\\.(t|j)s\$": "ts-jest"
    }
}
''';