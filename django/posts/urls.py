from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token
from .views import RegisterView
from rest_framework.routers import DefaultRouter
from .views import PostViewSet

urlpatterns = [
    path('api-token-auth/', obtain_auth_token),
    path('register/', RegisterView.as_view()),
]
router = DefaultRouter()
router.register('posts', PostViewSet, basename='posts')

urlpatterns += router.urls