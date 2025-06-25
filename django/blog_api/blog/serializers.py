from rest_framework import serializers
from .models import Post

class PostListSerializer(serializers.ModelSerializer):
    summary = serializers.SerializerMethodField()

    class Meta:
        model = Post
        fields = ['id', 'title', 'summary', 'created_at']

    def get_summary(self, obj):
        return obj.summary()

class PostDetailSerializer(serializers.ModelSerializer):
    author = serializers.StringRelatedField()

    class Meta:
        model = Post
        fields = ['id', 'title', 'content', 'author', 'created_at']
