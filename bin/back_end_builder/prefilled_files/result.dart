String resultFile() => '''
import UseCaseError from './useCaseError';

export default class Result<T, Y = UseCaseError> {

    private value?: T;
    private error?: Y;

    public isError: Boolean = false;

    constructor(error?: Y, value?: T) {
        if (error) {
            this.isError = true;
            this.error = error;
        } else
            this.value = value;
    }

    public getValue(): T {
        if (this.isError) {
            throw new Error("'C'ant get the value of an error result. Use 'errorValue' instead.")
        }

        return this.value as T;
    }

    public getError(): Y | undefined {
        if (this.isError) {
            return this.error as Y
        }

        return undefined;
    }

    public static fail<U, Y extends UseCaseError>(error: Y): Result<U, Y> {
        return new Result<U, Y>(error);
    }

    public static ok<T>(result: T): Result<T> {
        return new Result<T>(undefined, result);
    }
}
''';
