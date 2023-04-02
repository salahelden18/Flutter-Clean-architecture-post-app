import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

import 'form_submit_btn_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({super.key, required this.isUpdatePost, required this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              name: 'Title', multiLine: false, controller: _titleController),
          TextFormFieldWidget(
              name: 'Body', multiLine: true, controller: _bodyController),
          FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost),
        ],
      ),
    );
  }
}
