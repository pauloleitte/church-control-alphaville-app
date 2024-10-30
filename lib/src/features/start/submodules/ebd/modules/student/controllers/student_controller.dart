import '../../group/models/group_model.dart';
import '../../group/services/interfaces/group_service_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../../../../../../../shared/utils/filter_options.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../models/student_model.dart';
import '../services/interfaces/student_service_interface.dart';
import '../view-models/student_view_model.dart';

part 'student_controller.g.dart';

// ignore: library_private_types_in_public_api
class StudentController = _StudentControllerBase with _$StudentController;

abstract class _StudentControllerBase with Store {
  @observable
  StudentModel student = StudentModel();

  @observable
  PaginationModel pagination = PaginationModel();

  @observable
  bool busy = false;

  final IStudentService service;
  final IGroupService groupService;

  _StudentControllerBase(this.service, this.groupService);

  @observable
  List<StudentModel> students = [];

  @observable
  List<GroupModel> groups = [];

  @computed
  StudentViewModel get model => StudentViewModel(
        id: student.sId,
        name: student.name,
        phone: student.phone,
        email: student.email,
        group: student.group,
      );

  Future<void> getGroups() async {
    try {
      var result =
          await groupService.getGroups(FilterOptions(page: 1, sort: 'asc'));
      result.fold((l) {}, (response) async {
        groups = response.groups;
      });
    } catch (e) {
      busy = false;
    }
  }

  Future<void> getStudents(FilterOptions options) async {
    try {
      if (options.page != null) {
        if (options.page == 1) busy = true;
      }
      var result = await service.getStudents(options);
      result.fold((l) {}, (response) async {
        pagination = response.pagination;
        students = response.students;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> deleteStudent() async {
    try {
      busy = true;
      var result = await service.deleteStudent(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.STUDENT);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> updateStudent() async {
    try {
      busy = true;
      var result = await service.updateStudent(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.STUDENT);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  Future<void> createStudent() async {
    try {
      busy = true;
      var result = await service.createStudent(model);
      result.fold((l) {}, (_) async {
        Modular.to.navigate(AppRoutes.STUDENT);
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }
}
