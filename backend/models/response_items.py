from typing import Generic, TypeVar, List
from pydantic.generics import GenericModel

Item = TypeVar("Item")


class ResponseItems(GenericModel, Generic[Item]):
    items: List[Item]
    count: int
    num_offset: int

    @staticmethod
    def Of(
        items,
        offset,
        length=None,
    ):
        return ResponseItems(
            items=items,
            num_offset=offset,
            count=length or len(items),
        )
