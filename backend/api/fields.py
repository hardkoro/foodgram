from rest_framework import serializers
from webcolors import hex_to_name


class Hex2NameColor(serializers.Field):
    """Color encoding custom field."""

    def to_representation(self, value):
        return value

    def to_internal_value(self, data):
        try:
            return hex_to_name(data)
        except ValueError:
            raise serializers.ValidationError('No name for this color!')
