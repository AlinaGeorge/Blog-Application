from django.urls import path
from .views import CustomLoginView, PostListAPIView, PostDetailAPIView, CreatePostAPIView

urlpatterns = [
    path('api/login/', CustomLoginView.as_view(), name='login'),
    path('api/posts/', PostListAPIView.as_view(), name='post-list'),
    path('api/posts/<int:pk>/', PostDetailAPIView.as_view(), name='post-detail'),
    path('api/posts/', CreatePostAPIView.as_view(), name='post-create'),
]
