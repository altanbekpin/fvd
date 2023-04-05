from marshmallow import Schema, fields
from werkzeug.security import generate_password_hash, check_password_hash



    
class LegacySchema(Schema):
    id = fields.Int(dump_to='ID')
    name = fields.Str(dump_to='name')
    path = fields.Str(dump_to='path')
    parent_id = fields.Int(dump_to='parentID')
    is_file = fields.Bool(dump_to='isFile')
