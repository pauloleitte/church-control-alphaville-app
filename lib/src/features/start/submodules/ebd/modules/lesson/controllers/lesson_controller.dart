
import 'package:church_control/src/core/auth/models/user_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/services/interfaces/group_service_interface.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/services/interfaces/lesson_service_interface.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/student/models/student_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../../group/models/group_model.dart';
import '../models/lesson_model.dart';
import '../view-models/lesson_view_model.dart';

part 'lesson_controller.g.dart';

// ignore: library_private_types_in_public_api
class LessonController = _LessonControllerBase with _$LessonController;

abstract class _LessonControllerBase with Store {
  @observable
  LessonModel lesson = LessonModel();

  @observable
  List<LessonModel> lessons = [];

  @observable
  List<GroupModel> groups = [];

  @observable
  List<GroupModel> groupsByUser = [];

  @observable
  List<UserModel> secretaries = [];

  @observable
  List<UserModel> teachers = [];

  @observable
  List<StudentModel> students = [];

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  final ILessonService lessonService;

  final IGroupService groupService;

  _LessonControllerBase(this.lessonService, this.groupService);

  @computed
  LessonViewModel get model => LessonViewModel(
        sId: lesson.sId,
        name: lesson.name,
        description: lesson.description,
        group: lesson.group,
        attendance: lesson.attendance,
        offerValue: lesson.offerValue,
        secretary: lesson.secretary,
        date: lesson.date,
        teacher: lesson.teacher,
      );

  Future<void> getLessonsByGroupId(FilterOptions options) async {
    try {
      var result = await lessonService.getLessonsByGroupId(options);
      result.fold((l) {
        
      }, (response) async {
        lessons = response.lessons;
        pagination = response.pagination;
      });
    } catch (e) {
      busy = false;
    }
  }

  Future<void> getSecretaries() async {
    try {
      var result = await groupService.getSecretaries(model.group!.sId!);
      result.fold((l) {
        
      }, (response) async {
        secretaries = response;
      });
    } catch (e) {
       busy = false;
    }
  }

  Future<void> getTeachers() async {
    try {
      var result = await groupService.getTeachers(model.group!.sId!);
      result.fold((l) {
        
      }, (response) async {
        teachers = response;
      });
    } catch (e) {
       busy = false;
    }
  }

  Future<void> getStudents() async {
    try {
      var result = await groupService.getStudents(model.group!.sId!);
      result.fold((l) {
        
      }, (response) async {
        students = response;
      });
    } catch (e) {
       busy = false;
    }
  }

  Future<void> getGroups(FilterOptions filterOptions) async {
    try {
      var result =
          await groupService.getGroups(FilterOptions(page: 1, sort: 'asc'));
      result.fold((l) {
        
      }, (response) async {
        groups = response.groups;
      });
    } catch (e) {
       busy = false;
    }
  }

  Future<void> getLessons(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      var result = await lessonService.getLessons(options);
      result.fold((l) {
        
      }, (response) async {
        pagination = response.pagination;
        lessons = response.lessons;
      });
    } catch (e) {
       busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteLesson() async {
    try {
      busy = true;
      var result = await lessonService.deleteLesson(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.LESSON);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> updateLesson(bool isAttendanceUpdate) async {
    try {
      busy = true;
      var result = await lessonService.updateLesson(model);
      result.fold((l) {
        
      }, (_) async {
        
        if (!isAttendanceUpdate) {
          Modular.to.navigate(AppRoutes.LESSON);
        }
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> createLesson() async {
    try {
      busy = true;
      var result = await lessonService.createLesson(model);
      result.fold((l) {
        
      }, (_) async {
        
        Modular.to.navigate(AppRoutes.LESSON);
      });
    } catch (e) {
      busy = false;
      
    } finally {
      busy = false;
    }
  }

  Future<void> getGroupsByUserId(String userId) async {
    try {
      var result = await groupService.getGroupsByUserId(userId);
      result.fold((l) {
        
      }, (response) async {
        groupsByUser = response;
      });
    } catch (e) {
       busy = false;
    }
  }
}
