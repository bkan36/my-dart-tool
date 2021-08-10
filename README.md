# my-dart-tool

file-builder:

   -> take folder's name at first paramater

   -   create a folder in current directory with 3 files inside.
      * folder_name_controller.dart
      * folder_name_presenter.dart
      * folder_name_view.dart

architecture_builder:

   - create all folders for my flutter architecture

singleton_builder:

   - singleton file prefilled

use_case_builder

   -> take use case name (follow camelCase style) at first argument
   -> entity name (optional)
   -> the extension at third argument (optional default ".ts")

   - create 1 folder with 4 files prefilled
      * useCaseName.request-dto.ext
      * useCaseName.response-dto.ext
      * useCaseName.use-case.ext
      * index.ext (exports)

