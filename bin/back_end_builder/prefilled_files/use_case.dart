String useCaseFile() => '''
export default interface UseCase<Request = {}, Response = {}> {
    execute(req: Request): Promise<Response>;
}  
''';
