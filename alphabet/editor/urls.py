from os import name
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views
from . import ilsviews
from editor.models import MyOwlReady
s = MyOwlReady() ## class initialized, but object not created
print("Object created", MyOwlReady.getInstance()) # Object gets created here
urlpatterns = [
    path('lang/<str:lang>', views.home, name='editor-home'),
    path('ask/', views.send_question, name='ask-page'),
    path('getuniturk/', views.get_uniturk, name='uniturk-page'),
    path('addlabel/', views.add_label, name='addlabel-page'),
    path('editlabel/', views.edit_label, name='editlabel-page'),
    path('removeuniturk/', views.remove_uniturk, name='removeunit-page'),
    path('', views.projects, name='editor-projects'),
    path('login', views.MyLoginView.as_view(), name='login_page'),
    path('logout', views.MyLogoutView.as_view(), name='logout_page'),
    path('readfile', views.readfile, name='readfile'),
    path('autoPostTag', views.autoPostTag, name='autoPostTag'),
    path('addAutoPostWord', views.addAutoPostWord, name='addAutoPostWord'),
    path('tagger', views.tagger, name='tagger'),
    path('tagger/login', views.taggerLogin.as_view(), name='tagger_login'),
    path('tagger/logout', views.taggerLogout.as_view(), name='tagger_logout'),
    path('tagger/expert/', views.expert, name='expert'),
    path('tagger/stats', views.stats, name='tagger_stats'),
    path('tagger/expert/update', views.expertUpdate, name='tagger_expert_update'),
    path('tagger/expert/add', views.expertAdd, name='tagger_expert_add'),
    path('tagger/expert/all', views.expertAll, name='tagger_expert_all'),
    path('tagger/expert/remove', views.expertAll, name='tagger_expert_remove'),
    path('tagger/getStats/', views.get_tagger_stats, name='get_tagger_stats'),
    path('tagger/file/generate', views.generate_file, name='generate_file'),
    path('tagger/syntag', views.syntagger, name='syntagger'),
    path('tagger/syntag/add', views.add_syntag, name='add_syntag'),
    path('ils', ilsviews.ils, name='ils'),
    path('ils/teacher', ilsviews.teacher, name='teacher'),
    path('ils/getquestions', ilsviews.get_questions, name = 'get_questions'),
    path('ils/getanswer', ilsviews.get_answer, name='get_answer'),

    #path('tagger/syntag/download', views.syntag_download_result, name='download_syntag_result')
]

urlpatterns += [
    path('taxexpert', views.taxexpert, name='taxexpert'),
    path('taxexpert/knowledge/get', views.get_onto_text, name='get_onto_text'),
    path('taxexpert/knowledge/save', views.save_onto_text, name='save_onto_text'),
    path('taxexpert/knowledge/extractontology', views.get_owl_from_text, name='get_owl_from_text'),
    path('taxexpert/knowledge/search', views.search, name='search'),
    path('taxexpert/knowledge', views.tax_knowledge, name='tax_knowledge'),
    path('taxexpert/thesaurus', views.tax_thesaurus, name='tax_thesaurus'),
    path('taxexpert/login', views.tax_login.as_view(), name='tax_login'),
    path('taxexpert/logout', views.tax_logout.as_view(), name='tax_logout')

] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)