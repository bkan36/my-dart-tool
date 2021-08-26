String useCaseErrorFile() => '''
import { UseCaseErrorRes } from ".";

export default class UseCaseError extends Error {
    code: number;

    constructor(error: UseCaseErrorRes) {
        super(error.msg);
        this.name = this.getErrorType();
        this.code = error.code;
    }

    private getErrorType(): string {
        return this.constructor.name.toUpperCase();
    }
}
''';
