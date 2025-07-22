import 'package:induk/common/error/error_mapper.dart';
import 'package:induk/common/models/api_response.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/common/network/http_response_handler.dart';
import 'package:induk/features/user/model/inquiry.dart';
import 'package:induk/features/user/provider/inquiry_provider.dart';

class InquiryRepository {
  InquiryRepository({InquiryProvider? inquiryProvider})
      : _inquiryProvider = inquiryProvider ?? InquiryProvider();

  final InquiryProvider _inquiryProvider;

  /// 문의글 목록 조회
  Future<Result<List<Inquiry>>> requestInquiryList({
    required int page,
    int size = 10,
  }) async {
    try {
      final response = await _inquiryProvider.requestInquiryList(page: page);
      final jsonResponse = httpResponseHandler(response);

      final apiResponse = ApiResponse<List<Inquiry>>.fromJson(
        json: jsonResponse,
        fromDataJson: (dynamic jsonData) {
          if (jsonData is List) {
            return jsonData
                .map((e) => Inquiry.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          return [];
        },
      );

      final List<Inquiry> inquiryList = apiResponse.data ?? [];

      return Result.success(inquiryList);
    } catch (e) {
      return ErrorMapper.toFailure(e);
    }
  }

  /// 문의글 상세 조회
  Future<Result<Inquiry>> requestInquiry({
    required int id
  }) async {
    try {
      final response = await _inquiryProvider.requestInquiry(id: id);
      final jsonResponse = httpResponseHandler(response);

      final apiResponse = ApiResponse<Inquiry>.fromJson(
        json: jsonResponse,
        fromDataJson: (dynamic jsonData) {
            return Inquiry.fromJson(jsonData);
        },
      );

      final inquiry = apiResponse.data;

      if (inquiry == null) {
        return Result.failure(Exception('Inquiry data is null'), '문의글 상세 정보를 가져오지 못했습니다.');
      }

      return Result.success(inquiry);
    } catch (e) {
      return ErrorMapper.toFailure(e);
    }
  }

  void dispose() {
    _inquiryProvider.close();
  }
}