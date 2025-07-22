import 'package:flutter/material.dart';
import 'dart:io';

class DeletableImageTile extends StatelessWidget {
  final String imagePath;
  final VoidCallback onDelete;
  final double imageSize;
  final double borderRadius;

  const DeletableImageTile({
    super.key,
    required this.imagePath,
    required this.onDelete,
    this.imageSize = 100.0,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius + 4),
      ),
      child: Stack(
        children: [

          // 1. 이미지 표시 영역
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.file(
              File(imagePath),
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey[400],
                    size: imageSize * 0.5,
                  ),
                );
              },
            ),
          ),

          // 2. 삭제 버튼 (오른쪽 상단에 배치)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  shape: BoxShape.circle,
                  //border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}