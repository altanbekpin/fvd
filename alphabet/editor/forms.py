from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm
from .models import MyOntology

class AuthUserForm(AuthenticationForm, forms.ModelForm):
    class Meta:
        model = User
        fields = ('username', 'password')
    def __init__(self, *args,**kwargs):
        super().__init__(*args,**kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'

class ProjectForm(forms.ModelForm):
    class Meta:
        model = MyOntology
        fields = ('name', 'language', 'text')
    def __init__(self, *args,**kwargs):
        super().__init__(*args,**kwargs)



        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'
