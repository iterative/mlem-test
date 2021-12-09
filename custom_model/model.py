from typing import Any, ClassVar, Optional

from mlem.core.model import ModelHook, ModelIO, ModelType, Signature, SimplePickleIO


class CustomModel:
    def predict(self, value):
        return value + "a"


class CustomModelType(ModelType, ModelHook):
    type: ClassVar = "custommodel"
    valid_types: ClassVar = (CustomModel,)
    io: ModelIO = SimplePickleIO()

    @classmethod
    def process(cls, obj: CustomModel, sample_data: Optional[Any] = None, **kwargs) -> ModelType:
        return CustomModelType(model=obj, methods={"predict": Signature.from_method(obj.predict)})

    @classmethod
    def is_object_valid(cls, obj: Any) -> bool:
        return isinstance(obj, cls.valid_types)
